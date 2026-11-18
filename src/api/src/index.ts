import 'dotenv/config'
import express from 'express'
import cors from 'cors'
import publicRouter from './routes/publicRoutes'

const API_PORT = process.env.API_PORT ?? 3000

const app = express()

app.use(express.json())

app.use(cors({
  origin: '*',
  exposedHeaders: ['Authorization'],
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true     
}))

app.use('/api', publicRouter)

app.listen(API_PORT, () => console.log(`API rodando na porta ${API_PORT}`))