import React from 'react';
import { useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector, store } from '../../store';
import { DragSource } from '../../typings';
import {
  removeItem,
  updateQuantity,
  clear,
  addItem,
} from '../../store/cart';
import { getItemUrl, findAvailableSlot, isSlotWithItem } from '../../helpers';
import { Items } from '../../store/items';
import { buyItem } from '../../thunks/buyItem';
import bankIcon from '../../../images/card_bank.png?url';
import cashIcon from '../../../images/money.png?url';

const ShoppingCart: React.FC = () => {
  const dispatch = useAppDispatch();
  const items = useAppSelector((state) => state.cart.items);
  const shop = useAppSelector((state) => state.inventory.rightInventory);
  const [, drop] = useDrop<DragSource>(() => ({
    accept: 'SLOT',
    drop: (source) => {
      const slot = source.item.slot;
      const shopItem = shop.items[slot - 1];
      if (shopItem) {
        dispatch(addItem({ slot, item: shopItem as any, quantity: 1 }));
      }
    },
  }));

  const total = items.reduce((acc, item) => acc + item.item.price! * item.quantity, 0);

  const handlePay = async (method: 'bank' | 'cash') => {
    for (const entry of items) {
      if (!isSlotWithItem(entry.item)) continue;
      let player = store.getState().inventory.leftInventory;
      const data = Items[entry.item.name];
      const target =
        findAvailableSlot(entry.item, data!, player.items) ||
        player.items.find((s) => s.name === undefined);

      if (!target) {
        console.error('No slot for', entry.item.name);
        continue;
      }

      await dispatch(
        buyItem({
          fromSlot: entry.slot,
          fromType: shop.type,
          toSlot: target.slot,
          toType: player.type,
          count: entry.quantity,
        })
      );
    }
    dispatch(clear());
  };

  return (
    <div className="shopping-cart" ref={drop}>
      <h3 className="pockets-title">Shopping Cart</h3>
      <table className="cart-table">
        <tbody>
          {items.map((entry) => (
            <tr key={entry.slot}>
              <td>
                <img src={getItemUrl(entry.item)} alt="" width={32} />
              </td>
              <td className="cart-name">
                {entry.item.metadata?.label
                  ? entry.item.metadata.label
                  : Items[entry.item.name]?.label || entry.item.name}
              </td>
              <td className="cart-type">{entry.item.metadata?.quality || 'COMMON'}</td>
              <td className="qty-cell">
                <button onClick={() => dispatch(updateQuantity({ slot: entry.slot, quantity: Math.max(1, entry.quantity - 1) }))}>-</button>
                <input
                  type="number"
                  min={1}
                  value={entry.quantity}
                  onChange={(e) =>
                    dispatch(updateQuantity({
                      slot: entry.slot,
                      quantity: Math.max(1, Number(e.target.value)),
                    }))
                  }
                />
                <button onClick={() => dispatch(updateQuantity({ slot: entry.slot, quantity: entry.quantity + 1 }))}>+</button>
              </td>
              <td className="unit-price">${entry.item.price}</td>
              <td>
                <button className="remove-btn" onClick={() => dispatch(removeItem(entry.slot))}>🗑️</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <div className="cart-summary">
        <span className="total-label">Total Cost:</span>
        <span className="total-value">${total}</span>
      </div>
      <div className="cart-actions">
        <button className="pay-btn" onClick={() => handlePay('bank')}>
          <img src={bankIcon} alt="pay bank" width={20} />
          <span>Pay Bank</span>
        </button>
        <button className="pay-btn" onClick={() => handlePay('cash')}>
          <img src={cashIcon} alt="pay cash" width={20} />
          <span>Pay Cash</span>
        </button>
      </div>
    </div>
  );
};

export default ShoppingCart;
