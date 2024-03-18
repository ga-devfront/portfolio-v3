<template>
  <nav
    ref="fixedMenu"
    class="fixed-menu"
  >
    <NuxtLink
      :to="localPath('index')"
      class="fixed-menu__logo"
    >
      <img
        src="/logo.svg"
        :alt="$t('logoAlt')"
      >
    </NuxtLink>
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

const localPath = useLocalePath();

const menuItems : Array<MenuItemType> = [
  {
    to: 'index',
    name: 'routes.home',
  },
  {
    to: 'resume',
    name: 'routes.resume',
  },
  {
    to: 'projects',
    name: 'routes.projects',
  },
  {
    to: 'contact',
    name: 'routes.contact',
  },
]
</script>
