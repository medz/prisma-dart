import { defineConfig } from 'vitepress';

// https://vitepress.dev/reference/site-config
export default defineConfig({
  sitemap: {
    hostname: 'https://prisma.pub',
  },
  title: 'Prisma Client Dart',
  description:
    'Prisma Client Dart is an auto-generated type-safe ORM. It uses Prisma Engine as the data access layer and is as consistent as possible with the Prisma Prisma Client JS/TS APIs.',
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
      { icon: 'github', link: 'https://github.com/medz/prisma-dart' },
      { icon: 'twitter', link: 'https://twitter.com/shiweidu' },
    ],
    editLink: {
      pattern: 'https://github.com/odroe/prisma-dart/edit/main/docs/:path',
    },
    footer: {
      message: 'Released under the BSD-3-Clause License',
      copyright: `Copyright © ${new Date().getFullYear()} Seven Du & Odroe, Inc.`,
    },

    nav: [
      {
        text: 'Version',
        items: [
          {
            text: 'v4.0.0-alpha.*',
            link: '/',
          },
          {
            text: 'v3.x',
            link: 'https://prisma-dart-git-3x-herodeveloper.vercel.app/',
          },
        ],
      },
    ],

    sidebar: [
      {
        text: 'Getting Started',
        items: [
          { text: 'Introduction', link: '/getting-started/' },
          { text: 'Setup', link: '/getting-started/setup' },
          { text: 'Schema', link: '/getting-started/schema' },
        ],
      },
      {
        text: 'Queries',
        items: [
          { text: 'CRUD', link: '/queries/crud' },
          { text: 'Select Fields', link: '/queries/select-fields' },
          { text: 'Relation queries', link: '/queries/relation-queries' },
          {
            text: 'Filtering and Sorting',
            link: '/queries/filtering-and-sorting',
          },
          { text: 'Pagination', link: '/queries/pagination' },
          {
            text: 'Aggregation, grouping, and summarizing',
            link: '/queries/aggregation-grouping-summarizing',
          },
          {
            text: 'Transactions',
            link: '/queries/transactions',
          },
          {
            text: 'Raw database access',
            link: '/queries/raw-database-access',
          },
        ],
      },
    ],
  },
});
