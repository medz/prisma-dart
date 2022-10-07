import { defineConfig } from "vitepress";

export default defineConfig({
    title: "Prisma ORM for Dart",
    description: "Next-generation ORM for Dart & Flutter | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB",

    lastUpdated: true,
    cleanUrls: "without-subfolders",

    head: [
        // Basic
        ["link", { rel: "icon", type: "image/png", href: "/logo.svg" }],

        // Twitter
        ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
        ['meta', { name: 'twitter:site', content: '@odroeinc' }],

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
        logo: "/logo.svg",

        socialLinks: [
            { icon: 'twitter', link: 'https://twitter.com/odroeinc' },
            { icon: 'github', link: 'https://github.com/odroe/prisma-dart' },
        ],

        editLink: {
            pattern: "https://github.com/odroe/prisma-dart/edit/main/docs/:path",
        },

        nav: [
            { text: "Getting started", link: "/getting-started" },
            { text: "Guides", link: "/guides/" },
            { text: "Concepts", link: "/concepts" },
            {
                text: "Reference",
                items: [
                    { text: "Prisma official reference", link: "https://www.prisma.io/docs/reference" },
                    { text: "API reference", link: "https://pub.dev/documentation/orm/latest/" },
                    { text: "Prisma CLI reference", link: "/reference/cli" },
                ],
            },
            { text: "♥︎ Sponsor", link: "https://opencollective.com/prisma-dart" },
        ],

        sidebar: [
            {
                text: "Introduction",
                items: [
                    { text: "Getting started", link: "/getting-started" },
                    { text: "Concepts", link: "/concepts" },
                ],
            },
            {
                text: "Guides",
                items: [
                    { text: "Overview", link: "/guides/" },
                    { text: "Configuretion", link: "/guides/configuretion" },
                    { text: "Preview Features", link: "/guides/preview-features" },
                ],
            },
            {
                text: "Reference",
                items: [
                    { text: "Prisma CLI reference", link: "/reference/cli" },
                    { text: "API reference", link: "https://pub.dev/documentation/orm/latest/" },
                    { text: "Prisma official reference", link: "https://www.prisma.io/docs/reference" },
                ]
            }
        ],

        footer: {
            message: "Released under the BSD-3-Clause License",
            copyright: `Copyright © ${new Date().getFullYear()} Odroe Inc.`,
        },
    },

    markdown: {
        lineNumbers: false,
    },
});
