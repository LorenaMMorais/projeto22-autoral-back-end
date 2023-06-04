import { users } from '@prisma/client';
import bcrypt from 'bcrypt';
import { duplicatedEmailError } from './errors';
import userRepository from '@/repositories/user-repository';

export async function createUser({ email, password, role }: CreateUserParams): Promise<users> {
    await validateUniqueEmailOrFail(email);

    const hashedPassword = await bcrypt.hash(password, 15);
    return userRepository.create({
        email,
        password: hashedPassword,
        role
    });
}

async function validateUniqueEmailOrFail(email: string) {
    const userWithSameEmail = await userRepository.findByEmail(email);
    if (userWithSameEmail) throw duplicatedEmailError();
}

export type CreateUserParams = Pick<users, 'email' | 'password' | 'role'>;

const userService = {
    createUser
}

export * from './errors';
export default userService;