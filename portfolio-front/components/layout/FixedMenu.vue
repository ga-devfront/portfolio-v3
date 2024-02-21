<template>
  <nav class="fixed-menu">
    <ul class="fixed-menu__list">
      <LayoutMenuItem
        v-for="menuItem in menuItems"
        :key="menuItem.name"
        v-bind="menuItem"
      />
    </ul>
  </nav>
</template>

<script setup lang="ts">
import type { MenuItemType } from "~/components/layout/ts/FixedMenu";

const localPath = useLocalePath();

const menuItems : Array<MenuItemType> = [
  {
    to: localPath('index'),
    name: 'routes.home',
    icon: 'ri-home-2-fill'
  },
  {
    to: localPath('resume'),
    name: 'routes.resume',
    icon: 'ri-article-fill'
  },
  {
    to: localPath('projects'),
    name: 'routes.projects',
    icon: 'ri-code-box-fill'
  },
  {
    to: localPath('contact'),
    name: 'routes.contact',
    icon: 'ri-message-3-fill'
  },
]
</script>
