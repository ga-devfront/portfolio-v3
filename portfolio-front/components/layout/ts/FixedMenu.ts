export interface MenuItemType {
  to: string;
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
}
