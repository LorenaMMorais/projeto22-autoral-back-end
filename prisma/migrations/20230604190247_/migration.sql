/*
  Warnings:

  - You are about to drop the column `email` on the `customers` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `customers` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `employees` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `employees` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `users` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `users` will be added. If there are existing duplicate values, this will fail.
  - Made the column `user_id` on table `customers` required. This step will fail if there are existing NULL values in that column.
  - Made the column `phone` on table `customers` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user_id` on table `employees` required. This step will fail if there are existing NULL values in that column.
  - Made the column `description` on table `foods` required. This step will fail if there are existing NULL values in that column.
  - Made the column `order_id` on table `order_items` required. This step will fail if there are existing NULL values in that column.
  - Made the column `food_id` on table `order_items` required. This step will fail if there are existing NULL values in that column.
  - Made the column `customer_id` on table `orders` required. This step will fail if there are existing NULL values in that column.
  - Made the column `order_date` on table `orders` required. This step will fail if there are existing NULL values in that column.
  - Made the column `order_id` on table `payments` required. This step will fail if there are existing NULL values in that column.
  - Made the column `payment_date` on table `payments` required. This step will fail if there are existing NULL values in that column.
  - Made the column `customer_id` on table `reservations` required. This step will fail if there are existing NULL values in that column.
  - Made the column `table_id` on table `reservations` required. This step will fail if there are existing NULL values in that column.
  - Made the column `notes` on table `reservations` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `email` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "customers" DROP CONSTRAINT "customers_user_id_fkey";

-- AlterTable
ALTER TABLE "customers" DROP COLUMN "email",
DROP COLUMN "name",
ALTER COLUMN "user_id" SET NOT NULL,
ALTER COLUMN "phone" SET NOT NULL;

-- AlterTable
ALTER TABLE "employees" DROP COLUMN "email",
DROP COLUMN "name",
ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "foods" ALTER COLUMN "description" SET NOT NULL;

-- AlterTable
ALTER TABLE "order_items" ALTER COLUMN "order_id" SET NOT NULL,
ALTER COLUMN "food_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "orders" ALTER COLUMN "customer_id" SET NOT NULL,
ALTER COLUMN "order_date" SET NOT NULL;

-- AlterTable
ALTER TABLE "payments" ALTER COLUMN "order_id" SET NOT NULL,
ALTER COLUMN "payment_date" SET NOT NULL;

-- AlterTable
ALTER TABLE "reservations" ALTER COLUMN "customer_id" SET NOT NULL,
ALTER COLUMN "table_id" SET NOT NULL,
ALTER COLUMN "notes" SET NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "username",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "email" VARCHAR(255) NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "password" SET DATA TYPE VARCHAR(255);

-- CreateTable
CREATE TABLE "session" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "session_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "customers" ADD CONSTRAINT "customers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
