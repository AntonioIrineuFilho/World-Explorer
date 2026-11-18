import type { IUser } from "../interfaces/IUser";
import db from '../db'

class UserRepository {
    constructor() {}

    async create(data: IUser) {
        return await db.user.create({
            data: data
        })
    }

    async findUniqueByEmail(email: string) {
        return await db.user.findUnique({
            where: {
                email: email
            }
        })
    }
}

export default new UserRepository()