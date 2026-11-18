import zod from 'zod'

export const userCreateSchema = zod.object({
    name: zod.string().trim().min(5),
    email: zod.email().trim(),
    password: zod.string().trim().min(8)
})