import React, { useState, useEffect } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import InventoryHotbar from './InventoryHotbar';
import { useAppDispatch, useAppSelector } from '../../store';
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
import useKeyPress from '../../hooks/useKeyPress';
import InventoryTabs from './InventoryTabs';
import { selectRightInventory } from '../../store/inventory';
import { InventoryType } from '../../typings';

const Inventory: React.FC = () => {
  const [inventoryVisible, setInventoryVisible] = useState(false);
  const [showEquipment, setShowEquipment] = useState(false);
  const dispatch = useAppDispatch();
  const rightInventory = useAppSelector(selectRightInventory);

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

  useEffect(() => {
    if (!inventoryVisible) return;
    if (rightInventory.type && rightInventory.type !== InventoryType.PLAYER) {
      setShowEquipment(true);
    }
  }, [rightInventory.type, inventoryVisible]);

  useNuiEvent<{
    leftInventory?: InventoryProps;
    rightInventory?: InventoryProps;
  }>('setupInventory', (data) => {
    dispatch(setupInventory(data));
    !inventoryVisible && setInventoryVisible(true);
    if (data.rightInventory && data.rightInventory.type !== InventoryType.PLAYER) {
      setShowEquipment(true);
    } else {
      setShowEquipment(false);
    }
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
