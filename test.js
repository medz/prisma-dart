const { PrismaClient } = require("@prisma/client");

const prisma = PrismaClient({
  log: ["query", "info", "warn"],
});