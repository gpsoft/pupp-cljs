const puppeteer = require('puppeteer');

(async () => {
	const browser = await puppeteer.launch({
		args: ['--no-sandbox', '--disable-setuid-sandbox'],
		headless: false
	});
	const page = await browser.newPage();
	await page.goto('https://www.yahoo.co.jp/');
	await page.screenshot({path: 'yahoo.png', fullPage: true});

	await browser.close();
})();
