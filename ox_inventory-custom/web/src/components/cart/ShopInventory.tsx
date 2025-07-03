import React from 'react';
import InventoryGrid from '../inventory/InventoryGrid';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';
import ShoppingCart from './ShoppingCart';

const ShopInventory: React.FC = () => {
  const shopInventory = useAppSelector(selectRightInventory);

  return (
    <div className="shop-inventory">
      <h2 className="pockets-title">{shopInventory.label}</h2>
      <InventoryGrid inventory={shopInventory} showSlotNumbers={false} showWeightBar={false} />
      <ShoppingCart />
    </div>
  );
};

export default ShopInventory;
