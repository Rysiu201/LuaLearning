import React, { useEffect, useState } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import InventoryHotbar from './InventoryHotbar';
import { useAppDispatch } from '../../store';
import { refreshSlots, setAdditionalMetadata, setupInventory } from '../../store/inventory';
import { useExitListener } from '../../hooks/useExitListener';
import type { Inventory as InventoryProps } from '../../typings';
import EquipmentInventory from './EquipmentInventory';
import GroundInventory from './GroundInventory';
import LeftInventory from './LeftInventory';
import InventoryTabs from './InventoryTabs';
import Tooltip from '../utils/Tooltip';
import { closeTooltip } from '../../store/tooltip';
import InventoryContext from './InventoryContext';
import { closeContextMenu } from '../../store/contextMenu';
import Fade from '../utils/transitions/Fade';

const Inventory: React.FC = () => {
  const [inventoryVisible, setInventoryVisible] = useState(false);
  const [showEquipment, setShowEquipment] = useState(true);
  const dispatch = useAppDispatch();

  useNuiEvent<boolean>('setInventoryVisible', setInventoryVisible);
  useNuiEvent<false>('closeInventory', () => {
    setInventoryVisible(false);
    dispatch(closeContextMenu());
    dispatch(closeTooltip());
  });
  useExitListener(setInventoryVisible);

  useNuiEvent<{
    leftInventory?: InventoryProps;
    rightInventory?: InventoryProps;
  }>('setupInventory', (data) => {
    dispatch(setupInventory(data));
    !inventoryVisible && setInventoryVisible(true);
  });

  useNuiEvent('refreshSlots', (data) => dispatch(refreshSlots(data)));

  useNuiEvent('displayMetadata', (data: Array<{ metadata: string; value: string }>) => {
    dispatch(setAdditionalMetadata(data));
  });

  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.key.toLowerCase() === 'e') setShowEquipment(true);
      if (e.key.toLowerCase() === 'q') setShowEquipment(false);
    };

    if (inventoryVisible) {
      window.addEventListener('keyup', handler);
    }

    return () => window.removeEventListener('keyup', handler);
  }, [inventoryVisible]);

  return (
    <>
      <Fade in={inventoryVisible}>
        <div className="inventory-wrapper">
          <InventoryTabs showEquipment={showEquipment} setShowEquipment={setShowEquipment} />
          <Fade in={showEquipment}>
            <EquipmentInventory />
          </Fade>
          <Fade in={!showEquipment}>
            <GroundInventory />
          </Fade>
          <LeftInventory />
          <Tooltip />
          <InventoryContext />
        </div>
      </Fade>
      <InventoryHotbar />
    </>
  );
};

export default Inventory;
