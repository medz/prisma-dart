import { PrismaClient } from './js';

const prisma = new PrismaClient({});

const users = await prisma.user.findFirst({
  select: {
    posts: {},
  },
});
