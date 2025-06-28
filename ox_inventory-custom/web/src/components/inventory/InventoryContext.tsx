import { onUse } from '../../dnd/onUse';
import { onGive } from '../../dnd/onGive';
import { Locale } from '../../store/locale';
import { useAppSelector } from '../../store';
import React from 'react';
import { Menu, MenuItem } from '../utils/menu/Menu';
import SplitDialog from './SplitDialog';

interface DataProps {
  action: string;
  slot?: number;
}

const InventoryContext: React.FC = () => {
  const contextMenu = useAppSelector((state) => state.contextMenu);
  const item = contextMenu.item;
  const [splitVisible, setSplitVisible] = React.useState(false);

  const handleClick = (data: DataProps) => {
    if (!item) return;

    switch (data && data.action) {
      case 'use':
        onUse({ name: item.name, slot: item.slot });
        break;
      case 'give':
        onGive({ name: item.name, slot: item.slot });
        break;
      case 'split':
        setSplitVisible(true);
        break;
    }
  };


  return (
    <>
      <Menu>
        <MenuItem onClick={() => handleClick({ action: 'use' })} label={Locale.ui_use || 'Use'} />
        <MenuItem onClick={() => handleClick({ action: 'split' })} label="Split" />
        <MenuItem onClick={() => handleClick({ action: 'give' })} label={Locale.ui_give || 'Give'} />
      </Menu>
      <SplitDialog visible={splitVisible} onClose={() => setSplitVisible(false)} item={item} />
    </>
  );
};

export default InventoryContext;
