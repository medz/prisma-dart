import { defineConfig } from "vitepress";

export default defineConfig({
    title: "Prisma ORM for Dart",
    description: "Next-generation ORM for Dart & Flutter | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB",

    lastUpdated: true,
    cleanUrls: "without-subfolders",

    head: [
        // Basic
        ["link", { rel: "icon", type: "image/png", href: "/logo.png" }],

        // Twitter
        ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
        ['meta', { name: 'twitter:site', content: '@odroeinc' }],
    ],

    themeConfig: {
        logo: "/logo.png",

        socialLinks: [
            { icon: 'twitter', link: 'https://twitter.com/odroeinc' },
            { icon: 'github', link: 'https://github.com/odroe/prisma-dart' },
        ],

        editLink: {
            pattern: "https://github.com/odroe/prisma-dart/edit/main/docs/:path",
        },

        nav: [
            { text: "Getting started", link: "/getting-started" },
            { text: "Guides", link: "/guides" },
            { text: "Concepts", link: "/concepts" },
            {
                text: "Reference",
                items: [
                    { text: "Prisma Schema reference", link: "https://prisma.io/docs/reference/api-reference/prisma-schema-reference" },
                    { text: "Library API reference", link: "https://pub.dev/documentation/orm/latest/" },
                    { text: "Command reference", link: "reference/command" },
                ],
            },
            { text: "♥︎ Sponsor", link: "https://opencollective.com/prisma-dart" },
        ],
    },

    markdown: {
        lineNumbers: false,
    },
});
