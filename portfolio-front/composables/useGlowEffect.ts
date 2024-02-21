declare interface GlowConfig {
  proximity: number;
  opacity: number;
}

export const useGlowEffect = (event: Event, element: HTMLElement | null, glowConfig: GlowConfig) => {
  if (element === null) {
    return
  }

  const elementBounds = element.getBoundingClientRect()
  if (
    event?.x > elementBounds.left - glowConfig.proximity &&
    event?.x < elementBounds.left + elementBounds.width + glowConfig.proximity &&
    event?.y > elementBounds.top - glowConfig.proximity &&
    event?.y < elementBounds.top + elementBounds.height + glowConfig.proximity) {
    element.style.setProperty('--active', 1)
  } else {
    element.style.setProperty('--active', glowConfig.opacity || 0)
  }
  const elementCenter = [
    elementBounds.left + elementBounds.width * 0.5,
    elementBounds.top + elementBounds.height * 0.5
  ]
  let elementAngle = Math.atan2(event?.y - elementCenter[1], event?.x - elementCenter[0]) * 180 / Math.PI
  elementAngle = elementAngle < 0 ? elementAngle + 360 : elementAngle;
  element.style.setProperty('--start', elementAngle + 90)
}
