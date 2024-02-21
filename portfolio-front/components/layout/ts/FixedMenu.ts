export interface MenuItemType {
  to: string;
  name: string;
  icon: string;
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
  icon: {
    type: String,
    required: true,
  },
}
