<template>
  <li
    ref="comboContainer"
    class="menu-lang"
    :class="{ 'menu-lang--open': menuOpen }"
  >
    <button
      id="lang-select"
      ref="comboEl"
      class="menu-lang__button"
      role="combobox"
      :aria-expanded="menuOpen"
      aria-haspopup="listbox"
      aria-controls="lang-choices"
      :aria-activedescendant="`${prefixLangId}${activeIndex}`"
      tabindex="0"
      :name="$t('action.changeLanguage')"
      :aria-label="$t('action.changeLanguage')"
    >
      <span>{{ currentLocale.name }}</span>
      <i class="icon-dropdown ri-arrow-drop-down-line" />
    </button>
    <ul
      id="lang-choices"
      ref="listboxEl"
      class="menu-lang__options"
      role="listbox"
      tabindex="-1"
    >
      <li
        v-for="(option, index) in options"
        :id="`${prefixLangId}${index}`"
        :key="`${prefixLangId}${index}`"
        ref="optionsEl"
        role="option"
        class="menu-lang__option"
        :class="{ 'menu-lang__option--selected': activeIndex === index, 'menu-lang__option--current': currentLocaleIndex === index }"
        :aria-selected="activeIndex === index"
        @click.stop="onOptionClick(index)"
      >
        {{ option }}
      </li>
    </ul>
  </li>
</template>

<script setup lang="ts">
const { locale, locales, setLocale } = useI18n();

const comboContainer: null|HTMLLIElement = ref();
const comboEl: null|HTMLButtonElement = ref();
const listboxEl: null|HTMLUListElement = ref();
const optionsEl: Array<HTMLLIElement> = ref([]);

const menuOpen = ref(false);
const activeIndex = ref(0);
const searchString = ref('');
const searchTimeout = ref(null);

const currentLocale = computed(() => {
  return (locales.value).filter(i => i.code === locale.value)[0];
})
const currentLocaleIndex = computed(() => {
  return options.value.indexOf(currentLocale.value.name);
})
const options = computed(() => {
  return locales.value.map((locale) => locale.name);
})

const prefixLangId = 'lang-';
const SelectActions = {
  Close: 0,
  CloseSelect: 1,
  First: 2,
  Last: 3,
  Next: 4,
  Open: 5,
  PageDown: 6,
  PageUp: 7,
  Previous: 8,
  Select: 9,
  Type: 10,
};


/*
 * Helper functions
 */
const getOptionCode = (index) => {
  const optionName = options.value[index]
  const locale = (locales.value).filter(i => i.name === optionName)[0]
  return locale.code
}

const filterOptions = (options = [], filter, exclude = []) => {
  return options.filter((option) => {
    const matches = option.toLowerCase().indexOf(filter.toLowerCase()) === 0;
    return matches && exclude.indexOf(option) < 0;
  });
}

const getActionFromKey = (event) => {
  const { key, altKey, ctrlKey, metaKey } = event;
  const openKeys = ['ArrowDown', 'ArrowUp', 'Enter', ' '];
  if (!menuOpen.value && openKeys.includes(key)) {
    return SelectActions.Open;
  }

  if (key === 'Home') {
    return SelectActions.First;
  }
  if (key === 'End') {
    return SelectActions.Last;
  }

  if (
      key === 'Backspace' ||
      key === 'Clear' ||
      (key.length === 1 && key !== ' ' && !altKey && !ctrlKey && !metaKey)
  ) {
    return SelectActions.Type;
  }

  if (menuOpen.value) {
    if (key === 'ArrowUp' && altKey) {
      return SelectActions.CloseSelect;
    } else if (key === 'ArrowDown' && !altKey) {
      return SelectActions.Next;
    } else if (key === 'ArrowUp') {
      return SelectActions.Previous;
    } else if (key === 'PageUp') {
      return SelectActions.PageUp;
    } else if (key === 'PageDown') {
      return SelectActions.PageDown;
    } else if (key === 'Escape') {
      return SelectActions.Close;
    } else if (key === 'Enter' || key === ' ') {
      return SelectActions.CloseSelect;
    }
  }
}

const getIndexByLetter = (options, filter, startIndex = 0) => {
  const orderedOptions = [
    ...options.slice(startIndex),
    ...options.slice(0, startIndex),
  ];
  const firstMatch = filterOptions(orderedOptions, filter)[0];
  const allSameLetter = (array) => array.every((letter) => letter === array[0]);

  if (firstMatch) {
    return options.indexOf(firstMatch);
  }

  else if (allSameLetter(filter.split(''))) {
    const matches = filterOptions(orderedOptions, filter[0]);
    return options.indexOf(matches[0]);
  }

  else {
    return -1;
  }
}

const getUpdatedIndex = (currentIndex, maxIndex, action) => {
  const pageSize = 10;

  switch (action) {
    case SelectActions.First:
      return 0;
    case SelectActions.Last:
      return maxIndex;
    case SelectActions.Previous:
      return Math.max(0, currentIndex - 1);
    case SelectActions.Next:
      return Math.min(maxIndex, currentIndex + 1);
    case SelectActions.PageUp:
      return Math.max(0, currentIndex - pageSize);
    case SelectActions.PageDown:
      return Math.min(maxIndex, currentIndex + pageSize);
    default:
      return currentIndex;
  }
}

const isElementInView = (element) => {
  const bounding = element.getBoundingClientRect();

  return (
      bounding.top >= 0 &&
      bounding.left >= 0 &&
      bounding.bottom <=
      (window.innerHeight || document.documentElement.clientHeight) &&
      bounding.right <=
      (window.innerWidth || document.documentElement.clientWidth)
  );
}

const isScrollable = (element) => {
  return element && element.clientHeight < element.scrollHeight;
}

const maintainScrollVisibility = (activeElement, scrollParent) => {
  const { offsetHeight, offsetTop } = activeElement;
  const { offsetHeight: parentOffsetHeight, scrollTop } = scrollParent;

  const isAbove = offsetTop < scrollTop;
  const isBelow = offsetTop + offsetHeight > scrollTop + parentOffsetHeight;

  if (isAbove) {
    scrollParent.scrollTo(0, offsetTop);
  } else if (isBelow) {
    scrollParent.scrollTo(0, offsetTop - parentOffsetHeight + offsetHeight);
  }
}

const getSearchString = (char) => {
  if (typeof searchTimeout.value === 'number') {
    clearTimeout(searchTimeout.value);
  }

  searchTimeout.value = setTimeout(() => {
    searchString.value = '';
  }, 400);

  searchString.value += char;
  return searchString.value;
};

const selectOption = (index) => {
  activeIndex.value = index;
  setLocale(getOptionCode(index))
};

const updateMenuState = (open: boolean, callFocus = true) => {
  if (menuOpen.value === open) {
    return;
  }

  menuOpen.value = open;

  const activeID = open ? `${prefixLangId}${activeIndex.value}` : '';

  if (activeID === '' && !isElementInView(comboEl.value)) {
    comboEl.value.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  callFocus && comboEl.value.focus();
};

/*
 * Events listener functions
 */
const onComboBlur = (event) => {
  if (listboxEl.value.contains(event.relatedTarget)) {
    return;
  }

  if (menuOpen.value) {
    selectOption(activeIndex.value);
    updateMenuState(false, false);
  }
};

const onComboClick = () => {
  updateMenuState(!menuOpen.value, false);
};

const onComboKeyDown = (event) => {
  const { key } = event;
  const max = options.value.length - 1;

  const action = getActionFromKey(event, menuOpen.value);

  switch (action) {
    case SelectActions.Last:
    case SelectActions.First:
      updateMenuState(true);
      // fallsthrough
    case SelectActions.Next:
    case SelectActions.Previous:
    case SelectActions.PageUp:
    case SelectActions.PageDown:
      event.preventDefault();
      return onOptionChange(
          getUpdatedIndex(activeIndex.value, max, action)
      );
    case SelectActions.CloseSelect:
      event.preventDefault();
      selectOption(activeIndex.value);
      // fallsthrough
    case SelectActions.Close:
      event.preventDefault();
      return updateMenuState(false);
    case SelectActions.Type:
      return onComboType(key);
    case SelectActions.Open:
      event.preventDefault();
      return updateMenuState(true);
  }
};

const onComboType = (letter) => {
  updateMenuState(true);

  const searchStringValue = getSearchString(letter);
  const searchIndex = getIndexByLetter(
      options.value,
      searchStringValue,
      activeIndex.value + 1
  );

  if (searchIndex >= 0) {
    onOptionChange(searchIndex);
  }

  else {
    clearTimeout(searchTimeout.value);
    searchString.value = '';
  }
};

const onOptionChange = (index) => {
  activeIndex.value = index;

  if (isScrollable(listboxEl.value)) {
    maintainScrollVisibility(optionsEl.value[index], listboxEl.value);
  }

  if (!isElementInView(optionsEl.value[index])) {
    optionsEl.value[index].scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }
};

const onOptionClick = (index) => {
  onOptionChange(index);
  selectOption(index);
  updateMenuState(false);
};

onMounted(() => {
  if (comboEl.value !== null) {
    comboEl.value.addEventListener('blur', onComboBlur);
    comboEl.value.addEventListener('click', onComboClick);
    comboEl.value.addEventListener('keydown', onComboKeyDown);
  }

  if (listboxEl.value !== null) {
    listboxEl.value.addEventListener('focusout', onComboBlur);
  }
})

</script>
