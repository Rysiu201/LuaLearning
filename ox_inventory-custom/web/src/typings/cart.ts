import { SlotWithItem } from './slot';

export interface CartItem {
  slot: number;
  item: SlotWithItem;
  quantity: number;
}
