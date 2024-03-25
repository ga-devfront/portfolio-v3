<template>
  <li class="menu-item">
    <NuxtLink :to="localPath(props.to)" class="menu-item__link">
      <span class="menu-item__text">
        {{ $t(props.name) }}
      </span>
    </NuxtLink>
  </li>
</template>

<script setup lang="ts">
import { MenuItemProps } from "./ts/FixedMenu";

const props = defineProps(MenuItemProps);

const localPath = useLocalePath();
</script>
