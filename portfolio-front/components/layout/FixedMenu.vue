<template>
  <nav
    ref="fixedMenu"
    class="fixed-menu"
    :class="{ 'fixed-menu--open': menuOpen }"
    aria-labelledby="fixed-menu__label"
  >
    <label id="fixed-menu__label" class="sr-only">
      {{ $t("menuLabel") }}
    </label>
    <NuxtLink :to="localPath('index')" class="fixed-menu__logo">
      <img src="/logo.svg" :alt="$t('logoAlt')" />
    </NuxtLink>
    <button class="fixed-menu__toggle-button" @click="toggleMenu(!menuOpen)">
      <i
        :class="menuOpen ? 'ri-close-line' : 'ri-menu-3-line'"
        class="fixed-menu__toggle-button-icon"
        aria-hidden="true"
      />
    </button>
    <ul class="fixed-menu__list">
      <LayoutMenuItem
        v-for="menuItem in menuItems"
        :key="menuItem.name"
        v-bind="menuItem"
      />
      <li class="menu-separator" />
      <LayoutMenuLang />
    </ul>
  </nav>
</template>

<script setup lang="ts">
import type { MenuItemType } from "~/components/layout/ts/FixedMenu";

const route = useRoute();
const localPath = useLocalePath();

const fixedMenu: null | HTMLElement = ref();

const menuItems: Array<MenuItemType> = [
  {
    to: "index",
    name: "routes.home",
  },
  {
    to: "resume",
    name: "routes.resume",
  },
  {
    to: "projects",
    name: "routes.projects",
  },
  {
    to: "contact",
    name: "routes.contact",
  },
];

const menuOpen: boolean = ref(false);

watch(
  () => route.path,
  () => {
    toggleMenu(false);
  },
);

const closeMenuOutside = (event: Event): void => {
  if (
    !fixedMenu.value.contains(event.target) &&
    event.target !== fixedMenu.value
  ) {
    toggleMenu(false);
  }
};

const toggleMenu = (bool: boolean): void => {
  menuOpen.value = bool;
  if (menuOpen.value) {
    document.body.classList.add("no-scroll");
    document.addEventListener("click", closeMenuOutside);
  } else {
    document.body.classList.remove("no-scroll");
    document.removeEventListener("click", closeMenuOutside);
  }
};
</script>
