import React, { useState } from 'react';
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
  const dismiss = useDismiss(context, { outsidePressEvent: 'mousedown' });
  const { isMounted, styles } = useTransitionStyles(context);
  const { getFloatingProps } = useInteractions([dismiss]);

  const update = (n: number) => setQty(Math.min(max, Math.max(1, n)));

  return (
    <>
      {isMounted && (
        <FloatingPortal>
          <FloatingOverlay lockScroll className="useful-controls-dialog-overlay" data-open={visible} style={styles}>
            <FloatingFocusManager context={context}>
              <div ref={refs.setFloating} {...getFloatingProps()} className="useful-controls-dialog" style={styles}>
                <div className="useful-controls-dialog-WR">
                  <div className="useful-controls-dialog-title">
                    <p>SPLIT</p>
                    <div className="useful-controls-dialog-close" onClick={onClose}>
                      ×
                    </div>
                  </div>
                  <div className="useful-controls-content-wrapper">
                    <p>Item Quantity</p>
                    <input type="number" min={1} max={max} value={qty} onChange={(e) => update(Number(e.target.value))} />
                    <input type="range" min={1} max={max} value={qty} onChange={(e) => update(Number(e.target.value))} />
                    <div style={{ display: 'flex', gap: '8px', justifyContent: 'center' }}>
                      <button onClick={() => update(Math.floor(max / 2))}>1/2</button>
                      <button onClick={() => update(Math.floor(max / 3))}>1/3</button>
                      <button onClick={() => update(Math.floor(max / 4))}>1/4</button>
                    </div>
                    <div style={{ display: 'flex', gap: '8px', justifyContent: 'center' }}>
                      <button onClick={onClose}>{Locale.ui_cancel || 'Cancel'}</button>
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
