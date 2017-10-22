module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 11,
    fontFamily: 'Iosevka, Input, Menlo, monospace',
    cursorColor: 'rgba(248,28,229,0.8)',
    cursorShape: 'BEAM',
    cursorBlink: true,
    padding: '0 10px',
    colors: {},
    shell: '/usr/local/bin/fish',
    shellArgs: ['--login'],
    env: {},
    bell: 'SOUND',
    copyOnSelect: false,
    termCSS: `
      x-row {
         font-weight: 300;
         font-variant-ligatures: contextual;
      }
    `
  },

  plugins: [
    'hyper-makika',
    'hyperterm-alternatescroll',
    'hyperlinks',
    'hyper-tab-icons',
    'hypercwd',
  ],
};
