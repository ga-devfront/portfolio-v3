import type { RouteLocationRaw } from "vue-router";

export interface MenuItemType {
  to: RouteLocationRaw;
  name: string;
}

export const MenuItemPros = {
  to: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
};
