import { Locale } from '../../store/locale';
import React from 'react';
import {
  FloatingFocusManager,
  FloatingOverlay,
  FloatingPortal,
  useDismiss,
  useFloating,
  useInteractions,
  useTransitionStyles,
} from '@floating-ui/react';

interface Props {
  serverVisible: boolean;
  setServerVisible: React.Dispatch<React.SetStateAction<boolean>>;
}

const ServerInfos: React.FC<Props> = ({ serverVisible, setServerVisible }) => {
  const { refs, context } = useFloating({
    open: serverVisible,
    onOpenChange: setServerVisible,
  });

  const dismiss = useDismiss(context, {
    outsidePressEvent: 'mousedown',
  });

  const { isMounted, styles } = useTransitionStyles(context);

  const { getFloatingProps } = useInteractions([dismiss]);

  return (
    <>
      {isMounted && (
        <FloatingPortal>
          <FloatingOverlay lockScroll className="useful-controls-dialog-overlay" data-open={serverVisible} style={styles}>
            <FloatingFocusManager context={context}>
              <div ref={refs.setFloating} {...getFloatingProps()} className="useful-controls-dialog" style={styles}>

                <div className="useful-controls-dialog-WR">
                  <div className="useful-controls-dialog-title">
                    <p>{Locale.ui_ServerInfos || 'Server Infos'}</p>
                    <div className="useful-controls-dialog-close" onClick={() => setServerVisible(false)}>
                      <svg fill="none" className="PanelClose" viewBox="0 0 20 21" xmlns="http://www.w3.org/2000/svg"><linearGradient id="paint0_linear_1507_6319" gradientUnits="userSpaceOnUse" x1="10" x2="10" y1=".615" y2="20.615"><stop offset="0" stop-color="#2816f4" /><stop offset="1" stop-color="#7266ff" /></linearGradient><path d="m0 10.6149c0-3.73843 0-5.60767.803847-6.99997.526613-.91212 1.284033-1.66954 2.196153-2.19615 1.3923-.803851 3.26154-.803851 7-.803851 3.7385 0 5.6077 0 7 .803851.9121.52661 1.6695 1.28403 2.1962 2.19615.8038 1.3923.8038 3.26154.8038 6.99997 0 3.7385 0 5.6077-.8038 7-.5267.9121-1.2841 1.6696-2.1962 2.1962-1.3923.8038-3.2615.8038-7 .8038-3.73846 0-5.6077 0-7-.8038-.91212-.5266-1.66954-1.2841-2.196153-2.1962-.803847-1.3923-.803847-3.2615-.803847-7z" fill="#e5e5e8" /><g fill="url(#paint0_linear_1507_6319)"><path clip-rule="evenodd" d="m1.59436 6.37051c-.09292 1.02524-.09436 2.34758-.09436 4.24439 0 1.8969.00144 3.2192.09436 4.2444.09105 1.0047.26038 1.5758.50853 2.0056.39495.6841.96302 1.2522 1.64711 1.6471.4298.2482 1.00097.4175 2.00559.5086 1.02523.0929 2.34757.0943 4.24441.0943 1.8968 0 3.2192-.0014 4.2444-.0943 1.0046-.0911 1.5758-.2604 2.0056-.5086.6841-.3949 1.2522-.963 1.6471-1.6471.2482-.4298.4175-1.0009.5085-2.0056.093-1.0252.0944-2.3475.0944-4.2444 0-1.89681-.0014-3.21915-.0944-4.24439-.091-1.00461-.2603-1.57578-.5085-2.00558-.3949-.68409-.963-1.25216-1.6471-1.64712-.4298-.24814-1.001-.41747-2.0056-.50852-1.0252-.09292-2.3476-.09436-4.2444-.09436-1.89684 0-3.21918.00144-4.24441.09436-1.00462.09105-1.57579.26038-2.00559.50852-.68409.39496-1.25216.96303-1.64711 1.64712-.24815.4298-.41748 1.00097-.50853 2.00558zm-.790513-2.75558c-.803847 1.3923-.803847 3.26154-.803847 6.99997 0 3.7385 0 5.6077.803847 7 .526613.9121 1.284033 1.6696 2.196153 2.1962 1.3923.8038 3.26154.8038 7 .8038 3.7385 0 5.6077 0 7-.8038.9121-.5266 1.6695-1.2841 2.1962-2.1962.8038-1.3923.8038-3.2615.8038-7 0-3.73843 0-5.60767-.8038-6.99997-.5267-.91212-1.2841-1.66954-2.1962-2.19615-1.3923-.803851-3.2615-.803851-7-.803851-3.73846 0-5.6077 0-7 .803851-.91212.52661-1.66954 1.28403-2.196153 2.19615z" fill-rule="evenodd" /><path d="m7.4898 7.11474c-.29289-.29289-.76776-.29289-1.06066 0-.29289.2929-.29289.76777 0 1.06066l2.51026 2.5103-2.43953 2.4395c-.29289.2929-.29289.7678 0 1.0606.2929.2929.76777.2929 1.06066 0l2.43957-2.4395 2.4395 2.4395c.2928.2929.7677.2929 1.0606 0s.2929-.7678 0-1.0607l-2.4395-2.4394 2.5102-2.51026c.2929-.29289.2929-.76777 0-1.06066s-.7677-.29289-1.0606 0l-2.5102 2.51022z" /></g></svg>
                    </div>
                  </div>

                  <div className="container">
                    <div className="glitch" data-text="YourServer">YourServer</div>
                    <div className="glow">YourServer</div>
                    <p className="subtitle">Inventory Experiment</p>
                  </div>

                  <div className="useful-controls-content-wrapper">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    </p>
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    </p>
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    </p>
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    </p>
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

export default ServerInfos;
