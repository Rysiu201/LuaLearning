import React, { useState } from 'react';
import { useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector } from '../../store';
import { selectItemAmount, setItemAmount } from '../../store/inventory';
import { DragSource } from '../../typings';
import { onUse } from '../../dnd/onUse';
import { onGive } from '../../dnd/onGive';
import { fetchNui } from '../../utils/fetchNui';
import { Locale } from '../../store/locale';

const InventoryControl: React.FC = () => {
  const itemAmount = useAppSelector(selectItemAmount);
  const dispatch = useAppDispatch();


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
      <div className="inventory-control">
        <div className="inventory-control-wrapper">
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
        </div>
      </div>
    </>
  );
};

export default InventoryControl;
