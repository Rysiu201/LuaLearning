import React, { useState } from 'react';
import { fetchNui } from '../../utils/fetchNui';
import {
  FloatingFocusManager,
  FloatingOverlay,
  FloatingPortal,
  useDismiss,
  useFloating,
  useInteractions,
  useTransitionStyles,
} from '@floating-ui/react';
import { Locale } from '../../store/locale';
import type { SlotWithItem } from '../../typings';

interface Props {
  visible: boolean;
  onClose: () => void;
  item: SlotWithItem | null;
}

const SplitDialog: React.FC<Props> = ({ visible, onClose, item }) => {
  const max = item?.count ? Math.max(1, item.count - 1) : 1;
  const [qty, setQty] = useState(1);
  const { refs, context } = useFloating({ open: visible, onOpenChange: onClose });
  const dismiss = useDismiss(context, { outsidePressEvent: 'pointerdown' });
  const { isMounted, styles } = useTransitionStyles(context);
  const { getFloatingProps } = useInteractions([dismiss]);

  const update = (n: number) => setQty(Math.min(max, Math.max(1, n)));

  const confirm = () => {
    if (!item) return;
    fetchNui('splitItem', { slot: item.slot, count: qty });
    onClose();
  };

  return (
    <>
      {isMounted && (
        <FloatingPortal>
          <FloatingOverlay lockScroll className="split-dialog-overlay" data-open={visible} style={styles}>
            <FloatingFocusManager context={context}>
              <div
                ref={refs.setFloating}
                {...getFloatingProps({ onMouseDown: (e) => e.stopPropagation() })}
                className="split-dialog"
                style={styles}
              >
                <div className="split-dialog-WR">
                  <div className="split-dialog-title">
                    <p>SPLIT</p>
                    <div className="split-dialog-close" onClick={onClose}>
                      ×
                    </div>
                  </div>
                  <div className="useful-controls-content-wrapper">
                    <p>Item Quantity</p>
                    <input
                      type="number"
                      min={1}
                      max={max}
                      value={qty}
                      onChange={(e) => update(Number(e.target.value))}
                      style={{ textAlign: 'center' }}
                    />
                    <input
                      type="range"
                      min={1}
                      max={max}
                      value={qty}
                      onChange={(e) => update(Number(e.target.value))}
                      style={{ width: '80%' }}
                    />
                    <div style={{ display: 'flex', gap: '8px', justifyContent: 'center' }}>
                      <button onClick={() => update(Math.floor(max / 2))}>1/2</button>
                      <button onClick={() => update(Math.floor(max / 3))}>1/3</button>
                      <button onClick={() => update(Math.floor(max / 4))}>1/4</button>
                    </div>
                    <div style={{ display: 'flex', gap: '8px', justifyContent: 'center' }}>
                      <button onClick={onClose}>{Locale.ui_cancel || 'Cancel'}</button>
                      <button onClick={confirm}>{'Split'}</button>
                    </div>
                  </div>
                </div>
              </div>
            </FloatingFocusManager>
          </FloatingOverlay>
        </FloatingPortal>
      )}
    </>
  );
};

export default SplitDialog;
