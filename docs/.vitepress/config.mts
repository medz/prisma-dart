import { defineConfig } from "vitepress";

export default defineConfig({
  sitemap: {
    hostname: "https://prisma.pub",
  },
  title: "Prisma Dart",
  description:
    "Prisma Client Dart is an auto-generated type-safe ORM. It uses Prisma Engine as the data access layer and is as consistent as possible with the Prisma Client JS/TS APIs.",
  lastUpdated: true,
  head: [
    [
      "link",
      { rel: "icon", type: "image/svg+xml", href: "/prisma-dart.logo.svg" },
    ],
    [
      "script",
      {
        async: "",
        src: "https://www.googletagmanager.com/gtag/js?id=G-TLJ4LJL8HY",
      },
    ],
    [
      "script",
      {},
      `window.dataLayer = window.dataLayer || [];
       function gtag(){dataLayer.push(arguments);}
       gtag("js", new Date());
       gtag("config", "G-TLJ4LJL8HY");`,
    ],
  ],
  themeConfig: {
    logo: "/prisma-dart.logo.svg",
    search: {
      provider: "algolia",
      options: {
        appId: "0HCH0SFS0X",
        apiKey: "f075d8843b7e9649a9e017dafe482e0c",
        indexName: "prismapub",
      },
    },
    socialLinks: [
      { icon: "github", link: "https://github.com/medz/prisma-dart" },
      { icon: "x", link: "https://x.com/shiweidu" },
      { icon: "discord", link: "https://odroe.dev/chat" },
    ],
    editLink: {
      pattern: "https://github.com/odroe/prisma-dart/edit/main/docs/:path",
    },
    footer: {
      message: "Released under the BSD-3-Clause License",
      copyright: `Copyright © ${new Date().getFullYear()} Seven Du & Odroe, Inc.`,
    },

    sidebar: [
      {
        text: "Getting Started",
        items: [
          { text: "Introduction", link: "/getting-started/" },
          { text: "Setup", link: "/getting-started/setup" },
          { text: "Schema", link: "/getting-started/schema" },
          { text: "Flutter Integration", link: "/getting-started/flutter" },
          { text: "Deployment", link: "/getting-started/deployment" },
          { text: "Upgrade Guides", link: "/getting-started/upgrade_guides" },
        ],
      },
      {
        text: "Queries",
        items: [
          { text: "CRUD", link: "/queries/crud" },
          { text: "Select Fields", link: "/queries/select-fields" },
          { text: "Relation queries", link: "/queries/relation-queries" },
          {
            text: "Filtering and Sorting",
            link: "/queries/filtering-and-sorting",
          },
          { text: "Pagination", link: "/queries/pagination" },
          {
            text: "Aggregation, grouping, and summarizing",
            link: "/queries/aggregation-grouping-summarizing",
          },
          {
            text: "Transactions",
            link: "/queries/transactions",
          },
          {
            text: "Raw database access",
            link: "/queries/raw-database-access",
          },
        ],
      },
      {
        text: "References",
        items: [
          {
            text: "Client Reference",
            link: "/references/client-api",
          },
          {
            text: "Model Delegate Reference",
            link: "/references/model-delegate",
          },
          {
            text: "package:orm Reference",
            link: "https://pub.dev/documentation/orm",
          },
        ],
      },
    ],
  },
});
