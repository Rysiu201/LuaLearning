import React, { useState } from 'react';
import { useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector } from '../../store';
import { selectItemAmount, setItemAmount } from '../../store/inventory';
import { DragSource } from '../../typings';
import { onUse } from '../../dnd/onUse';
import { onGive } from '../../dnd/onGive';
import { fetchNui } from '../../utils/fetchNui';
import { Locale } from '../../store/locale';
import UsefulControls from './UsefulControls';
import ServerInfos from './ServerInfos';

const InventoryControl: React.FC = () => {
  const itemAmount = useAppSelector(selectItemAmount);
  const dispatch = useAppDispatch();

  const [infoVisible, setInfoVisible] = useState(false);
  const [serverVisible, setServerVisible] = useState(false);

  const [, use] = useDrop<DragSource, void, any>(() => ({
    accept: 'SLOT',
    drop: (source) => {
      source.inventory === 'player' && onUse(source.item);
    },
  }));

  const [, give] = useDrop<DragSource, void, any>(() => ({
    accept: 'SLOT',
    drop: (source) => {
      source.inventory === 'player' && onGive(source.item);
    },
  }));

  const inputHandler = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.target.valueAsNumber =
      isNaN(event.target.valueAsNumber) || event.target.valueAsNumber < 0 ? 0 : Math.floor(event.target.valueAsNumber);
    dispatch(setItemAmount(event.target.valueAsNumber));
  };

  return (
    <>
      <UsefulControls infoVisible={infoVisible} setInfoVisible={setInfoVisible} />
      <ServerInfos serverVisible={serverVisible} setServerVisible={setServerVisible} />
      <div className="inventory-control">
        <div className="inventory-control-wrapper">
          <img className="InventoryLogo" src="https://cdn.frvgs.com/assets/custom/InventoryLogo.svg" />
          <div className="inventory-control-input-WR">
            <input
              className="inventory-control-input"
              type="number"
              defaultValue={itemAmount}
              onChange={inputHandler}
              min={0}
            />
          </div>
          <button className="inventory-control-button" ref={use}>
            <div className="inventory-control-buttonTxt">
              {Locale.ui_use || 'Use'}
            </div>
          </button>
          <button className="inventory-control-button" ref={give}>
            <div className="inventory-control-buttonTxt">
              {Locale.ui_give || 'Give'}
            </div>
          </button>
          <button className="inventory-control-button" onClick={() => fetchNui('exit')}>
            <div className="inventory-control-buttonTxt">
              {Locale.ui_close || 'Close'}
            </div>
          </button>
          <div className="inventory-control-separator"></div>
          <button className="inventory-control-button" onClick={() => setInfoVisible(true)}>
            <div className="inventory-control-buttonTxt">
              {Locale.ui_info || 'Infos'}
            </div>
          </button>
          <button className="inventory-control-button" onClick={() => setServerVisible(true)}>
            <div className="inventory-control-buttonTxt">
              {Locale.ui_info || 'Server'}
            </div>
          </button>
        </div>
      </div>
    </>
  );
};

export default InventoryControl;
