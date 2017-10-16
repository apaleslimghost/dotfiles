'use babel';

import {usePackage, configSet} from 'atom-use-package';

usePackage('nucleus-dark-ui');
usePackage('makika-light-syntax');
usePackage('makika-syntax', {
	init() {
		configSet('core', {
			themes: ['nucleus-dark-ui', 'makika-syntax'],
		});
	},
});
usePackage('file-icons');
usePackage('no-title-bar', {
	init() {
		configSet('core', {
			useCustomTitleBar: true,
			titleBar: 'custom',
		});
	},
});

usePackage('minimap');
usePackage('blame');
usePackage('indent-detective');

usePackage('vim-mode-plus');
usePackage('which-key');
usePackage('project-plus');
usePackage('close-other-panes');
usePackage('single-click-open');

usePackage('prettier-atom');
usePackage('language-babel');
usePackage('autocomplete-modules');

//TODO, the whole atom-ide-ui family

usePackage('linter-eslint');

usePackage('highlight-selected');

usePackage('docblockr');
