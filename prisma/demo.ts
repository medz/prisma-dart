import { PrismaClient } from './js';

const prisma = new PrismaClient();

prisma.user.findUnique({
  select: null,
  where: {
    id: 1,
  },
});
