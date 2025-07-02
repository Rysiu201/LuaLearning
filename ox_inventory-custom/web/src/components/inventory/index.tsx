import React, { useState, useEffect } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import InventoryHotbar from './InventoryHotbar';
import { useAppDispatch } from '../../store';
import { refreshSlots, setAdditionalMetadata, setupInventory } from '../../store/inventory';
import { useExitListener } from '../../hooks/useExitListener';
import type { Inventory as InventoryProps } from '../../typings';
import RightInventory from './RightInventory';
import LeftInventory from './LeftInventory';
import Tooltip from '../utils/Tooltip';
import { closeTooltip } from '../../store/tooltip';
import InventoryContext from './InventoryContext';
import { closeContextMenu } from '../../store/contextMenu';
import Fade from '../utils/transitions/Fade';
import useKeyPress from '../../hooks/useKeyPress';
import InventoryTabs from './InventoryTabs';

const Inventory: React.FC = () => {
  const [inventoryVisible, setInventoryVisible] = useState(false);
  const [showEquipment, setShowEquipment] = useState(false);
  const dispatch = useAppDispatch();

  const qPressed = useKeyPress('q');
  const ePressed = useKeyPress('e');

  useNuiEvent<boolean>('setInventoryVisible', setInventoryVisible);
  useNuiEvent<false>('closeInventory', () => {
    setInventoryVisible(false);
    dispatch(closeContextMenu());
    dispatch(closeTooltip());
  });
  useExitListener(setInventoryVisible);

  useEffect(() => {
    if (inventoryVisible && ePressed) {
      setShowEquipment(true);
    }
  }, [ePressed, inventoryVisible]);

  useEffect(() => {
    if (inventoryVisible && qPressed) {
      setShowEquipment(false);
    }
  }, [qPressed, inventoryVisible]);

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

  return (
    <>
      <Fade in={inventoryVisible}>
        <div className="inventory-wrapper">
          <InventoryTabs
            showEquipment={showEquipment}
            setShowEquipment={setShowEquipment}
          />
          <Fade in={showEquipment}>
            <RightInventory />
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
