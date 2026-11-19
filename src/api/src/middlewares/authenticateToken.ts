import type { Request, Response, NextFunction } from 'express'
import Jwt from '../security/jwt'

export function authenticateToken(req: Request, res: Response, next: NextFunction) {
    const authorization = req.headers.authorization
    if (!authorization?.startsWith('Bearer ')) {
        return res.status(401).json({ message: 'TOKEN AUSENTE OU INVÁLIDO' })
    }
    try {
        const token = authorization.substring(7).trim()
        res.locals.userId = Jwt.verifyToken(token)
        return next()
    } catch {
        return res.status(401).json({ message: 'TOKEN INVÁLIDO OU EXPIRADO' })
    }
}
