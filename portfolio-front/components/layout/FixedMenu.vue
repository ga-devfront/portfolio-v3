<template>
  <nav class="fixed-menu glow-effect-container" ref="fixedMenu">
    <div class="glow-effect"></div>
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
import {useGlowEffect} from "~/composables/useGlowEffect";

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

const fixedMenu : HTMLDivElement | null = ref()

const glowEffect = {
  proximity: 5,
  opacity: 0,
}

onMounted(() => {
  document.body.addEventListener('pointermove', (event) => useGlowEffect(event, fixedMenu.value, glowEffect))
})
onUnmounted(() => {
  document.body.removeEventListener('pointermove', (event) => useGlowEffect(event, fixedMenu.value, glowEffect))
})
</script>
