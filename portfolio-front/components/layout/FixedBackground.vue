<template>
  <div id="background" aria-hidden="true">
    <div class="background__gradiant"></div>
    <svg class="background__grid">
      <defs>
        <pattern
          id="gridRect"
          width="60"
          height="60"
          x="50%"
          y="-1"
          patternUnits="userSpaceOnUse"
        >
          <path d="M.5 200V.5H200" fill="none"></path>
        </pattern>
      </defs>
      <rect
        width="100%"
        height="100%"
        stroke-width="0"
        fill="url(#gridRect)"
      ></rect>
    </svg>
  </div>
</template>
<script setup lang="ts"></script>
