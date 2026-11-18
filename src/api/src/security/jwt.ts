import 'dotenv/config'
import jwt from 'jsonwebtoken'

class Jwt {
    constructor() {}

    generateToken(userId: number) {
        const JWT_SECRET = process.env.JWT_SECRET
        if (!JWT_SECRET) return new Error('JWT SECRET INDEFINIDO')
        return jwt.sign({ id: userId }, JWT_SECRET, { expiresIn: '24h' })
    }
}

export default new Jwt()