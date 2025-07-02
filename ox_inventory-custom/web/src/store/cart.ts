import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { SlotWithItem } from '../typings';

export interface CartItem {
  slot: number;
  item: SlotWithItem;
  quantity: number;
}

interface CartState {
  items: CartItem[];
}

const initialState: CartState = {
  items: [],
};

export const cartSlice = createSlice({
  name: 'cart',
  initialState,
  reducers: {
    addItem: (state, action: PayloadAction<CartItem>) => {
      const idx = state.items.findIndex((it) => it.slot === action.payload.slot);
      if (idx >= 0) {
        state.items[idx].quantity += action.payload.quantity;
      } else {
        state.items.push(action.payload);
      }
    },
    removeItem: (state, action: PayloadAction<number>) => {
      state.items = state.items.filter((it) => it.slot !== action.payload);
    },
    updateQuantity: (state, action: PayloadAction<{ slot: number; quantity: number }>) => {
      const item = state.items.find((it) => it.slot === action.payload.slot);
      if (item) item.quantity = action.payload.quantity;
    },
    clear: (state) => {
      state.items = [];
    },
  },
});

export const { addItem, removeItem, updateQuantity, clear } = cartSlice.actions;
export default cartSlice.reducer;
