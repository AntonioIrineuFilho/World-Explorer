import type { Request, Response } from 'express'
import type { IUser } from '../interfaces/IUser'
import Jwt from '../security/jwt'
import bcrypt from 'bcrypt'
import userRepository from '../repositories/userRepository'

class UserController {
    async authenticate(req: Request, res: Response) {
        const { email, password: exposedPassword } = req.body
        try {
            const user = await userRepository.findUniqueByEmail(email)
            if (!user) return res.status(404).json({ message: 'USUÁRIO NÃO ENCONTRADO' })
            const isPasswordValid = await bcrypt.compare(exposedPassword, user.password)
            if (!isPasswordValid) return res.status(401).json({ message: 'SENHA INCORRETA' })
            const { password, ...safeUser } = user
            const token = Jwt.generateToken(user.id)
            return res.status(200)
                .set('Authorization', `Bearer ${token}`)
                .json({ message: 'OPERAÇÃO BEM SUCEDIDA', accessToken: token, tokenType: 'Bearer', data: safeUser })
        } catch (error) {
            console.error(error)
            return res.status(500).json({ message: 'ERRO AO REALIZAR OPERAÇÃO' })
        }
    }

    async create(req: Request, res: Response) {
        const { name, email, password } = req.body
        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(password, salt)
        const data: IUser = { name, email, password: hashedPassword }
        try {
            await userRepository.create(data)
            return res.status(201).json({ message: 'OPERAÇÃO BEM SUCEDIDA' })
        } catch (error) {
            console.error(error)
            return res.status(400).json({ message: 'NÃO FOI POSSÍVEL CADASTRAR. VERIFIQUE SE O E-MAIL JÁ ESTÁ EM USO.' })
        }
    }

    async me(_req: Request, res: Response) {
        try {
            const userId = res.locals.userId as number
            const user = await userRepository.findUniqueById(userId)
            if (!user) return res.status(401).json({ message: 'USUÁRIO NÃO ENCONTRADO' })
            const { password, ...safeUser } = user
            return res.status(200).json({ message: 'OPERAÇÃO BEM SUCEDIDA', data: safeUser })
        } catch (error) {
            console.error(error)
            return res.status(500).json({ message: 'ERRO AO CONSULTAR USUÁRIO' })
        }
    }
}

export default new UserController()
