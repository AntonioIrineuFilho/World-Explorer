import type { IUser } from '../interfaces/IUser'
import db from '../db'

class UserRepository {
    async create(data: IUser) {
        return db.user.create({ data })
    }

    async findUniqueByEmail(email: string) {
        return db.user.findUnique({ where: { email } })
    }

    async findUniqueById(id: number) {
        return db.user.findUnique({ where: { id } })
    }
}

export default new UserRepository()
