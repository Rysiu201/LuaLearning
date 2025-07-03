import { store } from '../store';
import { DragSource } from '../typings';
import { addItem } from '../store/cart';
import { SlotWithItem } from '../typings';

export const onAddToCart = (source: DragSource, item: SlotWithItem) => {
  store.dispatch(addItem({ slot: item.slot, item, quantity: 1 }));
};
