<template>
  <div class="default-layout">
    <header class="header">
      <LayoutAnimatedLogo />
    </header>
    <LayoutFixedMenu />
    <div class="content">
      <slot />
    </div>
    <LayoutFixedBackground />
  </div>
</template>

<script setup lang="ts">
</script>
