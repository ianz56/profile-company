"use client";

import React, { useState } from "react";
import { ChevronDown } from "lucide-react";

const faqs = [
	{
		question: "Bagaimana cara memastikan kualitas sayuran yang dikirim?",
		answer: "Setiap sayuran yang dikirim telah melalui proses Quality Control (QC) yang ketat. Kami menyortir, membersihkan, dan mengemas sayuran dengan standar tinggi agar tetap segar sampai ke tangan Anda.",
	},
	{
		question: "Apakah SegarTani melayani pengiriman ke luar kota?",
		answer: "Saat ini jangkauan utama kami meliputi Bandung dan sekitarnya. Untuk melihat jangkauan pengiriman lengkap, silakan kunjungi halaman Lokasi kami.",
	},
	{
		question: "Bagaimana sistem paket langganan sayur mingguan bekerja?",
		answer: "Anda dapat memilih paket sayur mingguan sesuai kebutuhan keluarga. Kami akan mengirimkan paket sayuran segar yang dikurasi khusus setiap minggunya langsung ke rumah Anda.",
	},
	{
		question: "Apakah saya bisa memesan produk dalam jumlah besar untuk restoran?",
		answer: "Tentu! Kami menyediakan layanan Distribusi Grosir khusus untuk restoran, supermarket, dan hotel dengan harga yang lebih kompetitif. Silakan hubungi tim sales kami untuk informasi lebih lanjut.",
	},
	{
		question: "Apa yang membuat sayuran SegarTani berbeda dengan di pasar?",
		answer: "Sayuran kami ditanam dengan metode organik tanpa pestisida kimia sintetis dan dikirim dalam waktu kurang dari 24 jam setelah panen untuk memastikan kesegaran maksimal.",
	},
];

export default function FAQAccordion() {
	const [openIndex, setOpenIndex] = useState<number | null>(null);

	const toggleAccordion = (index: number) => {
		setOpenIndex(openIndex === index ? null : index);
	};

	return (
		<section className="py-24 bg-gray-50 border-t border-gray-100">
			<div className="container mx-auto px-6 max-w-4xl">
				<div className="text-center mb-16" data-aos="fade-up">
					<h2 className="text-4xl font-extrabold text-black mb-4">
						Pertanyaan yang Sering Diajukan
					</h2>
					<p className="text-gray-500 text-lg">
						Temukan jawaban atas pertanyaan umum seputar layanan SegarTani.
					</p>
				</div>

				<div className="space-y-4">
					{faqs.map((faq, index) => (
						<div
							key={index}
							className="bg-white border border-gray-200 rounded-2xl overflow-hidden shadow-sm transition-all duration-300"
							data-aos="fade-up"
							data-aos-delay={index * 100}
						>
							<button
								onClick={() => toggleAccordion(index)}
								className="w-full flex items-center justify-between p-6 text-left focus:outline-none focus-visible:ring-2 focus-visible:ring-[#00AA13]/50 focus-visible:bg-gray-50"
							>
								<span className="text-lg font-bold text-gray-900 pr-8">
									{faq.question}
								</span>
								<div
									className={`flex-shrink-0 w-8 h-8 rounded-full bg-[#00AA13]/10 flex items-center justify-center text-[#00AA13] transition-transform duration-300 ${
										openIndex === index ? "rotate-180" : ""
									}`}
								>
									<ChevronDown size={20} />
								</div>
							</button>

							<div
								className={`overflow-hidden transition-all duration-300 ease-in-out ${
									openIndex === index
										? "max-h-96 opacity-100 pb-6 px-6"
										: "max-h-0 opacity-0 px-6"
								}`}
							>
								<p className="text-gray-600 leading-relaxed pt-2 border-t border-gray-100">
									{faq.answer}
								</p>
							</div>
						</div>
					))}
				</div>
			</div>
		</section>
	);
}
