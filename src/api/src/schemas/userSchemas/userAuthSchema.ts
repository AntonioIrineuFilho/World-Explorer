import zod from 'zod'

export const userAuthSchema = zod.object({
    email: zod.email().trim(),
    password: zod.string().trim().min(8)
})