<template>
  <li class="menu-item">
    <NuxtLink
      :to="localPath(props.to)"
      class="menu-item__link"
    >
      <span class="menu-item__text">
        {{ $t(props.name) }}
      </span>
    </NuxtLink>
  </li>
</template>

<script setup lang="ts">
import { MenuItemPros } from "~/components/layout/ts/FixedMenu";

const props = defineProps(MenuItemPros);

const localPath = useLocalePath();
</script>
