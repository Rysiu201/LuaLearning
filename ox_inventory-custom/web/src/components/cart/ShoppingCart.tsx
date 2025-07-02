import React from 'react';
import { useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector } from '../../store';
import { DragSource } from '../../typings';
import { removeItem, updateQuantity, clear, addItem } from '../../store/cart';
import { getItemUrl } from '../../helpers';
import { Items } from '../../store/items';

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

  const handlePay = (method: 'bank' | 'cash') => {
    // Placeholder for payment logic
    console.log('Pay', method, items);
    dispatch(clear());
  };

  return (
    <div className="shopping-cart" ref={drop}>
      <h3>Shopping Cart</h3>
      <table className="cart-table">
        <thead>
          <tr>
            <th>Icon</th>
            <th>Name</th>
            <th>Type</th>
            <th>Qty</th>
            <th>Unit</th>
            <th>Total</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {items.map((entry) => (
            <tr key={entry.slot}>
              <td>
                <img src={getItemUrl(entry.item)} alt="" width={32} />
              </td>
              <td>
                {entry.item.metadata?.label
                  ? entry.item.metadata.label
                  : Items[entry.item.name]?.label || entry.item.name}
              </td>
              <td>{entry.item.metadata?.quality || 'COMMON'}</td>
              <td>
                <button onClick={() => dispatch(updateQuantity({ slot: entry.slot, quantity: Math.max(1, entry.quantity - 1) }))}>-</button>
                {entry.quantity}
                <button onClick={() => dispatch(updateQuantity({ slot: entry.slot, quantity: entry.quantity + 1 }))}>+</button>
              </td>
              <td>${entry.item.price}</td>
              <td>${entry.item.price! * entry.quantity}</td>
              <td>
                <button onClick={() => dispatch(removeItem(entry.slot))}>🗑️</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <div className="cart-summary">
        <span>Total: ${total}</span>
        <button onClick={() => handlePay('bank')}>Pay with Bank</button>
        <button onClick={() => handlePay('cash')}>Pay with Cash</button>
      </div>
    </div>
  );
};

export default ShoppingCart;
