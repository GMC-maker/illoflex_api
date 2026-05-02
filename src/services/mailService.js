const nodemailer = require("nodemailer");

const createMailTransporter = () => {
	return nodemailer.createTransport({
		host: process.env.SMTP_HOST,
		port: Number(process.env.SMTP_PORT),
		secure: process.env.SMTP_SECURE === "true",
		auth: {
			user: process.env.SMTP_USER,
			pass: process.env.SMTP_PASS,
		},
	});
};

const buildResultLinkUrl = (token) => {
	const frontendUrl = process.env.FRONTEND_URL || "http://localhost:5173";
	return `${frontendUrl}/tus-resultados/${token}`;
};

const sendTemporaryResultLinkEmail = async ({ email, token }) => {
	const transporter = createMailTransporter();
	const resultLink = buildResultLinkUrl(token);

	await transporter.sendMail({
		from: process.env.SMTP_FROM || process.env.SMTP_USER,
		to: email,
		subject: "IlloFlex - Tu enlace temporal de resultados",
		text: [
			"Hola,",
			"",
			"Aqui tienes tu enlace temporal para consultar los resultados de tu test vocacional de IlloFlex:",
			resultLink,
			"",
			"Recuerda que este enlace caduca en 7 dias.",
			"",
			"Si no has solicitado este enlace, puedes ignorar este correo.",
		].join("\n"),
		html: `
			<p>Hola,</p>
			<p>Aqui tienes tu enlace temporal para consultar los resultados de tu test vocacional de IlloFlex.</p>
			<p>
				<a
					href="${resultLink}"
					style="
						display: inline-block;
						padding: 12px 20px;
						background-color: #2563eb;
						color: #ffffff;
						text-decoration: none;
						border-radius: 8px;
						font-weight: 600;
					"
				>
					Ver mis resultados
				</a>
			</p>
			<p>Si el boton no funciona, puedes copiar y pegar este enlace en tu navegador:</p>
			<p><a href="${resultLink}">${resultLink}</a></p>
			<p>Recuerda que este enlace caduca en 7 dias.</p>
			<p>Si no has solicitado este enlace, puedes ignorar este correo.</p>
		`,

	});
};

module.exports = {
	sendTemporaryResultLinkEmail,
};
