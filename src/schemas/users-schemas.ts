import Joi from 'joi';
import { CreateUserParams } from '@/services/users-service';

export const createUserSchema = Joi.object<CreateUserParams>({
    email: Joi.string().email().required(),
    password: Joi.string().min(8).required(),
    role: Joi.boolean().required()
});