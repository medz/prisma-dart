import { defineConfig } from 'vitepress';

// https://vitepress.dev/reference/site-config
export default defineConfig({
  sitemap: {
    hostname: 'https://prisma.pub',
  },
  title: 'Prisma Dart',
  description:
    'Next-generation ORM for Dart & Flutter | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB',
  lastUpdated: true,
  head: [
    [
      'link',
      { rel: 'icon', type: 'image/svg+xml', href: '/prisma-dart.logo.svg' },
    ],
    [
      'script',
      {
        async: '',
        src: 'https://www.googletagmanager.com/gtag/js?id=G-TLJ4LJL8HY',
      },
    ],
    [
      'script',
      {},
      `window.dataLayer = window.dataLayer || [];
       function gtag(){dataLayer.push(arguments);}
       gtag("js", new Date());
       gtag("config", "G-TLJ4LJL8HY");`,
    ],
  ],
  themeConfig: {
    logo: '/prisma-dart.logo.svg',
    search: {
      provider: 'algolia',
      options: {
        appId: '0HCH0SFS0X',
        apiKey: 'f075d8843b7e9649a9e017dafe482e0c',
        indexName: 'prismapub',
      },
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/vuejs/vitepress' },
      { icon: 'twitter', link: 'https://twitter.com/shiweidu' },
    ],
    editLink: {
      pattern: 'https://github.com/odroe/prisma-dart/edit/main/docs/:path',
    },
    footer: {
      message: 'Released under the BSD-3-Clause License',
      copyright: `Copyright © ${new Date().getFullYear()} Seven Du & Odroe, Inc.`,
    },

    // https://vitepress.dev/reference/default-theme-config
    nav: [{ text: 'Docs', link: '/docs/' }],

    sidebar: {
      '/docs/': [
        {
          text: 'Introduction',
          items: [
            { text: "What's Prisma Dart client", link: '/docs/' },
            { text: 'Why Using?', link: '/docs/why' },
            { text: 'Installation', link: '/docs/installation' },
            { text: 'Getting Started', link: '/docs/getting-started' },
          ],
        },
      ],
    },

    // sidebar: [
    //   {
    //     text: 'Examples',
    //     items: [
    //       { text: 'Markdown Examples', link: '/markdown-examples' },
    //       { text: 'Runtime API Examples', link: '/api-examples' },
    //     ],
    //   },
    // ],
  },
});
