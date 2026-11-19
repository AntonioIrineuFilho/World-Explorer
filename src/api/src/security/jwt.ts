import 'dotenv/config'
import jwt, { type JwtPayload } from 'jsonwebtoken'

class Jwt {
    generateToken(userId: number) {
        const secret = process.env.JWT_SECRET
        if (!secret) throw new Error('JWT_SECRET não definido')
        return jwt.sign({ id: userId }, secret, { expiresIn: '24h' })
    }

    verifyToken(token: string): number {
        const secret = process.env.JWT_SECRET
        if (!secret) throw new Error('JWT_SECRET não definido')
        const payload = jwt.verify(token, secret) as JwtPayload
        if (typeof payload.id !== 'number') throw new Error('Token sem identificador de usuário')
        return payload.id
    }
}

export default new Jwt()
