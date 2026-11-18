import type { Request, Response } from 'express'
import type { IUser } from '../interfaces/IUser'
import Jwt from '../security/jwt'
import bcrypt from 'bcrypt'
import userRepository from '../repositories/userRepository'

class UserController {
    constructor() {}

    async authenticate(req: Request, res: Response) {
        const { email, password:exposedPassword } = req.body
        try {
            const user = await userRepository.findUniqueByEmail(email)
            if (!user) return res.status(404).json({"message": "USUÁRIO NÃO ENCONTRADO"}) 
            const isPasswordValid = await bcrypt.compare(exposedPassword, user.password)
            if (!isPasswordValid) return res.status(401).json({"message": "SENHA INCORRETA"}) 
            const {password, ...safeUser} = user
            const token = Jwt.generateToken(user.id)
            return res.status(200).set('Authorization', `Bearer ${token}`).json({"message": "OPERAÇÃO BEM SUCEDIDA", "data": safeUser})
        } catch (error) {
            return res.status(400).json({"message": "ERROR AO REALIZAR OPERAÇÃO", "error": error})
        }
    }

    async create(req: Request, res: Response) {
        const { name, email, password } = req.body
        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(password, salt)
        const data: IUser = {
            name: name,
            email: email,
            password: hashedPassword
        } 
        try {
            await userRepository.create(data)
            return res.status(201).json({"message": "OPERAÇÃO BEM SUCEDIDA"})
        } catch (error) {
            return res.status(400).json({"message": "ERROR AO REALIZAR OPERAÇÃO", "error": error})
        }
    }
}

export default new UserController()