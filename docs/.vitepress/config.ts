import { defineConfig } from "vitepress";

export default defineConfig({
    title: "Prisma client Dart",
    description: "Next-generation ORM for Dart & Flutter | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB",

    cleanUrls: true,
    lastUpdated: true,

    head: [
        // Basic
        ["link", { rel: "icon", type: "image/svg+xml", href: "/prisma-dart.svg" }],

        // Google Analytics
        ['script', { async: '', src: 'https://www.googletagmanager.com/gtag/js?id=G-TLJ4LJL8HY' }],
        [
            'script', 
            {},
            'window.dataLayer = window.dataLayer || [];' +
            'function gtag(){dataLayer.push(arguments);}' +
            'gtag("js", new Date());' +
            'gtag("config", "G-TLJ4LJL8HY");'
        ],
    ],

    themeConfig: {
        logo: "/prisma-dart.svg",

        socialLinks: [
            { icon: 'twitter', link: 'https://twitter.com/odroeinc' },
            { icon: 'github', link: 'https://github.com/odroe/prisma-dart' },
        ],

        editLink: {
            pattern: "https://github.com/odroe/prisma-dart/edit/main/docs/:path",
        },

        nav: [
            { text: "Documentation", link: '/docs/' },
            { text: "API reference", link: 'https://pub.dev/documentation/orm' },
            { text: "♥︎ Sponsor", link: "https://opencollective.com/prisma-dart" },
        ],

        sidebar: {
            "/docs/": [
                {
                    text: "Introduction",
                    items: [
                        {
                            text: "What is Prisma?",
                            link: "/docs/",
                        },
                        {
                            text: "Getting Started",
                            link: "/docs/getting-started",
                        },
                        {
                            text: "Configuration",
                            link: "/docs/configuration",
                        },
                        { text: "Logging", link: "/docs/logging" },
                    ],
                },
                {
                    text: "Prisma Client",
                    items: [
                        { text: "CRUD", link: "/docs/crud" },
                        { text: "Fluent API", link: "/docs/fluent-api" },
                        { text: "Aggregation", link: "/docs/aggregation" },
                        { text: "Grouping", link: "/docs/grouping" },
                        { text: "Transactions", link: "/docs/transactions" },
                        { text: "Raw database access", link: "/docs/raw-database-access" },
                    ],
                },
                {
                    text: 'Migrations',
                    items: [
                        { text: 'Migration from 2.x', link: '/docs/migration-from-2' },
                    ],
                },
            ],
        },

        footer: {
            message: "Released under the BSD-3-Clause License",
            copyright: `Copyright © ${new Date().getFullYear()} Odroe Inc.`,
        },
    },

    markdown: {
        lineNumbers: true,
    },
});
