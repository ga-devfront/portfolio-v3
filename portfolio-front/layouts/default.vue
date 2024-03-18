<template>
  <div class="default-layout">
    <header class="header container">
      <LayoutFixedMenu />
    </header>
    <div class="content">
      <slot />
    </div>
    <LayoutFixedBackground />
  </div>
</template>

<script setup lang="ts">
</script>
