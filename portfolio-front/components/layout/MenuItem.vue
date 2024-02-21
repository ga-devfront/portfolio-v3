<template>
  <li class="menu-item" >
    <NuxtLink :to="props.to" class="menu-item__link" ref="glowContainer">
      <span class="menu-item__icon">
              <i :class="props.icon"></i>
      </span>
      <span class="menu-item__name">{{ $t(props.name) }}</span>
    </NuxtLink>
  </li>
</template>

<script setup lang="ts">
import { MenuItemPros } from "~/components/layout/ts/FixedMenu";

const props = defineProps(MenuItemPros);
</script>
